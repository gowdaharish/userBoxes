#include "userbox.hpp"

#include <QDebug>
#include <QUrl>

UserBox::UserBox(const QString& name, const QString& gender, const QString& city, const QUrl& picture, const bool selected, QObject* parent)
    : QObject{parent}, _name{name}, _gender{gender}, _city{city}, _picture{picture.toString()}, _selected{selected}
{
    if (name.isEmpty() || gender.isEmpty() || city.isEmpty() || !picture.isValid() || picture.isEmpty())
        qWarning() << "user data is incomplete!" << name << gender << city << picture  << endl;
}

void UserBox::setSelected(const bool selected)
{
    if (selected == _selected)
        return;

    _selected = selected;
    emit selectedChanged();
}
