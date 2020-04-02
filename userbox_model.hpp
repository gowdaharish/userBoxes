#pragma once

#include "userbox.hpp"

#include <QAbstractListModel>

class NetworkManager;

class UserBoxModel : public QAbstractListModel
{
    Q_OBJECT

public:
    UserBoxModel(QObject* parent = nullptr);

    enum UserBoxRoles
    {
        NameRole = Qt::UserRole + 1,
        CityRole,
        GenderRole,
        PictureRole,
    };

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int = Qt::DisplayRole) const override;

    Q_INVOKABLE void addUserBox();
    Q_INVOKABLE void deleteUserBox(const int index);

protected:
    QHash<int, QByteArray> roleNames() const override;

private slots:
    void handleResults(const QString& name, const QString& city, const QString& gender, const QUrl& picture);

private:
    QVector<UserBox*> _userBoxes;
    NetworkManager* _manager;
};
