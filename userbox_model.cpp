#include "userbox_model.hpp"
#include "userbox.hpp"
#include "network_manager.h"

#include <QDebug>
#include <QObject>

UserBoxModel::UserBoxModel(QObject* parent) : QAbstractListModel(parent)
{
    _manager = new NetworkManager{this};
    connect(_manager, &NetworkManager::resultReady, this, &UserBoxModel::handleResults);
}

int UserBoxModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)
    return _userBoxes.size();
}

QVariant UserBoxModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid())
        return {};

    const auto& box      = _userBoxes.at(index.row());
    switch (role)
    {
    case NameRole:
        return box->name();
    case CityRole:
        return box->city();
    case GenderRole:
        return box->gender();
    case PictureRole:
        return box->picture();
    }

    return {};
}

// add new color box
void UserBoxModel::addUserBox()
{
    if (!_manager)
    {
        qCritical() << "add user boxes is called without network manager" << endl;
    }
    // since the network requests are queued, no need to check for its status
    // we can process the results as and when they come
    _manager->requestData();
}

// delete a color box
void UserBoxModel::deleteUserBox(const int index)
{
    if (_userBoxes.isEmpty())
    {
        qDebug() << "delete called when there is no user box";
        return;
    }

    beginRemoveRows({}, index, index);
    _userBoxes.takeAt(index)->deleteLater();
    endRemoveRows();
    emit layoutChanged();
}

// the results came from the managers reply
void UserBoxModel::handleResults(const QString& name, const QString& city, const QString& gender, const QUrl& picture)
{
    const auto insertPos = rowCount();
    beginInsertRows(QModelIndex(), insertPos, insertPos);

    auto selected = false;
    if (_userBoxes.size() == 0)
         selected = true;

    const auto box = new UserBox{name, gender, city, picture, selected, this};
    _userBoxes.push_back(box);
    endInsertRows();
}

QHash<int, QByteArray> UserBoxModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[CityRole] = "city";
    roles[GenderRole] = "gender";
    roles[PictureRole] = "picture";
    return roles;
}
