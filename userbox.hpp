#pragma once

#include <QObject>
#include <QString>

class UserBox : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool selected READ selected WRITE setSelected NOTIFY selectedChanged)

public:
    UserBox(const QString& name, const QString& gender, const QString& city,
             const QUrl& picture, const bool selected = false, QObject* parent = nullptr);

    QString name() const {return _name;}
    QString gender() const {return _gender;}
    QString city() const {return  _city;}
    QString picture() const {return _picture;}
    bool selected() const {return  _selected;}
    void setSelected(const bool selected);

signals:
    void selectedChanged();

private:
    QString _name;
    QString _gender;
    QString _city;
    QString _picture;
    bool _selected;
};
