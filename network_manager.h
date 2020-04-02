#define pragma once

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>

class NetworkManager : public QObject
{
    Q_OBJECT

public:
    NetworkManager(QObject* parent = nullptr);

public slots:
    void requestData() const;

private slots:
    void processReply(QNetworkReply* reply);

signals:
    void resultReady(const QString& name, const QString& city, const QString& gender, const QUrl& picture);

private:
    QNetworkAccessManager* _manager;
};
