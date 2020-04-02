#include "network_manager.h"

#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

namespace {
const auto API = QString{"https://randomuser.me/api"};
}

NetworkManager::NetworkManager(QObject* parent) : QObject{parent}
{
    _manager = new QNetworkAccessManager{this};
    connect(_manager, &QNetworkAccessManager::finished, this, &NetworkManager::processReply);
}

void NetworkManager::requestData() const
{
    if (!_manager)
    {
        qCritical() << "manager is absent, can't make a request" << endl;
        return;
    }

    _manager->get(QNetworkRequest(QUrl{API}));
}

void NetworkManager::processReply(QNetworkReply* reply)
{
    // failing to get an employee data shouldn't be considered critical
    // just move on
    if (reply->error() != QNetworkReply::NoError)
        qWarning() << "error occured. Error: " << reply->error();

    QJsonParseError jsonError;
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll(), &jsonError);
    if (jsonError.error != QJsonParseError::NoError){
        qWarning() << jsonError.errorString();
    }

    QJsonObject rootObj = document.object();

    if (rootObj.isEmpty())
    {
        qWarning() << "JSON data received is empty, aborting" << endl;
        return;
    }

    QJsonArray array{rootObj.take("results").toArray()};
    auto list = array.toVariantList()[0].toMap();

    if (list.isEmpty())
    {
        qWarning() << "list is empty, failed to retreive the user information" << endl;
        return;
    }

    auto nameMap = list.take("name").toMap();
    const auto firstName = nameMap["first"].toString();
    const auto lastName = nameMap["last"].toString();
    const auto title = nameMap.take("title").toString();
    const auto gender = list.take("gender").toString();
    const auto city = list.take("location").toMap().take("city").toString();
    const auto picture = list.take("picture").toMap().take("large").toString();

    emit resultReady(title + " " + firstName + " " + lastName, city, gender, picture);
}
