import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 52
    color: "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        // ========================================================
        // IZQUIERDA: CÁPSULA WORKSPACES (COLISIÓN CARTOON + FLOTACIÓN)
        // ========================================================
        Rectangle {
            id: wsCapsule
            implicitHeight: 40
            implicitWidth: wsRow.implicitWidth + 24
            radius: 20
            clip: true

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1a00f2fe" } 
                GradientStop { position: 0.4; color: "#05ffffff" } 
                GradientStop { position: 1.0; color: "#26000000" } 
            }
            border.width: 0

            // Al cambiar el ancho de wsRow, la cápsula entera rebota
            Behavior on implicitWidth {
                SpringAnimation { spring: 7.0; damping: 0.15 }
            }

            Row {
                id: wsRow
                anchors.centerIn: parent
                spacing: 3

                // ==============================================
                // LÓGICA DE COLISIÓN GLOBAL (SQUASH & STRETCH)
                // ==============================================
                property int activeWs: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
                
                onActiveWsChanged: {
                    collisionAnim.restart()
                }

                SequentialAnimation {
                    id: collisionAnim
                    // 1. Aplastamiento rápido (los botones se chocan y superponen)
                    NumberAnimation { target: wsRow; property: "spacing"; to: -10; duration: 80; easing.type: Easing.OutQuad }
                    // 2. Rebote de goma a su separación original
                    SpringAnimation { target: wsRow; property: "spacing"; to: 3; spring: 5.0; damping: 0.12 }
                }

                Repeater {
                    model: [1, 2, 3, 4, 5]

                    Rectangle {
                        id: wsBtn
                        required property int modelData
                        property bool isActive: wsRow.activeWs === modelData
                        property bool isHovered: wsMouse.containsMouse

                        implicitWidth: wsBtn.isActive ? 54 : (wsBtn.isHovered ? 34 : 28)
                        implicitHeight: 28
                        radius: 14

                        // ==============================================
                        // ANIMACIÓN DE FLOTACIÓN (ORGÁNICO)
                        // ==============================================
                        property real floatY: 0
                        SequentialAnimation on floatY {
                            loops: Animation.Infinite
                            running: true
                            NumberAnimation { to: -1.5; duration: 1200 + (wsBtn.modelData * 150); easing.type: Easing.InOutSine }
                            NumberAnimation { to: 1.5; duration: 1200 + (wsBtn.modelData * 150); easing.type: Easing.InOutSine }
                        }

                        // Aura exterior del botón activo
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -1
                            radius: parent.radius + 1
                            color: "transparent"
                            border.color: wsBtn.isActive ? "#5900f2fe" : "transparent"
                            border.width: 1
                            visible: wsBtn.isActive
                        }

                        gradient: Gradient {
                            GradientStop { 
                                position: 0.0 
                                color: wsBtn.isActive ? "#cc00f2fe" : (wsBtn.isHovered ? "#3300f2fe" : "transparent")
                            }
                            GradientStop { 
                                position: 1.0 
                                color: wsBtn.isActive ? "#40003b5e" : (wsBtn.isHovered ? "#1a0077b6" : "transparent")
                            }
                        }

                        border.color: wsBtn.isActive ? "#b300f2fe" : (wsBtn.isHovered ? "#4000f2fe" : "transparent")
                        border.width: 1

                        // Sombra del texto flotante
                        Text {
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: 1
                            anchors.verticalCenterOffset: 1 + wsBtn.floatY
                            text: wsBtn.modelData
                            color: "#40000000" 
                            font.bold: true
                            font.pixelSize: 13
                            font.family: "JetBrains Mono"
                            visible: wsBtn.isActive
                            scale: textMain.scale
                        }

                        // Texto principal con rebote 
                        Text {
                            id: textMain
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: wsBtn.floatY
                            text: wsBtn.modelData
                            color: wsBtn.isActive ? "#ffffff" : (wsBtn.isHovered ? "#b0e8ff" : "#66b0e8ff")
                            font.bold: true
                            font.pixelSize: 13
                            font.family: "JetBrains Mono"
                            
                            scale: wsBtn.isActive ? 1.25 : 1.0
                            
                            Behavior on scale {
                                SpringAnimation { spring: 9.0; damping: 0.15 }
                            }
                        }

                        // Expansión del botón
                        Behavior on implicitWidth {
                            SpringAnimation {
                                spring: 8.5
                                damping: 0.12
                                epsilon: 0.01
                            }
                        }

                        MouseArea {
                            id: wsMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                collisionAnim.restart();
                                // Se pasan el comando y el parámetro por separado
                                Hyprland.dispatch("workspace", wsBtn.modelData.toString());
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // ========================================================
        // CENTRO: TÍTULO DE VENTANA
        // ========================================================
        Rectangle {
            implicitHeight: 40
            implicitWidth: Math.min(windowTitleText.implicitWidth + 36, 420)
            radius: 20
            clip: true

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1a00f2fe" }
                GradientStop { position: 0.4; color: "#05ffffff" }
                GradientStop { position: 1.0; color: "#26000000" }
            }
            border.width: 0

            Text {
                id: windowTitleText
                anchors.centerIn: parent
                width: parent.width - 24
                text: Hyprland.activeWindow ? Hyprland.activeWindow.title : "Hyprland Desktop"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 12
                font.family: "JetBrains Mono"
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Item { Layout.fillWidth: true }

        // ========================================================
        // DERECHA: ESTADO DEL SISTEMA
        // ========================================================
        Rectangle {
            implicitHeight: 40
            implicitWidth: sysRow.implicitWidth + 28
            radius: 20
            clip: true

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#1a00f2fe" }
                GradientStop { position: 0.4; color: "#05ffffff" }
                GradientStop { position: 1.0; color: "#26000000" }
            }
            border.width: 0

            Row {
                id: sysRow
                anchors.centerIn: parent
                spacing: 14

                Text {
                    text: "VOL 60%"
                    color: "#ffffff"
                    font.bold: true
                    font.pixelSize: 12
                    font.family: "JetBrains Mono"
                }

                Text {
                    text: "WiFi: Connected"
                    color: "#b0e8ff"
                    font.bold: true
                    font.pixelSize: 12
                    font.family: "JetBrains Mono"
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    implicitHeight: 26
                    implicitWidth: clockText.implicitWidth + 18
                    radius: 13

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#4000a3e0" } 
                        GradientStop { position: 1.0; color: "#2000629b" } 
                    }
                    border.color: "#40ffffff" 
                    border.width: 1

                    Text {
                        id: clockText
                        anchors.centerIn: parent
                        text: Qt.formatDateTime(new Date(), "hh:mm - dd/MM")
                        color: "#ffffff"
                        font.bold: true
                        font.pixelSize: 12
                        font.family: "JetBrains Mono"

                        Timer {
                            interval: 1000
                            running: true
                            repeat: true
                            onTriggered: {
                                clockText.text = Qt.formatDateTime(new Date(), "hh:mm - dd/MM");
                            }
                        }
                    }
                }
            }
        }
    }
}