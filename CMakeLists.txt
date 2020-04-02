cmake_minimum_required(VERSION 3.1.0)

project(user-boxes)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Quick Core REQUIRED)

add_executable(userBoxes
    userbox.cpp
    userbox_model.cpp
    network_manager.cpp
    main.cpp
    qml.qrc
)

target_link_libraries(userBoxes Qt5::Quick)




