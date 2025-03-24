import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: width / 1.586
    visible: true
    title: qsTr("Business Card")

    color: "white"

    component ContactInfo: QtObject {

        // Diese properties sind immer sichtbar
        property string name
        property url photo

        // General properties:
        property string occupation
        property string company

        // Details properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }

    ContactInfo {
        id: myContactInfo

        name: "LifterSam"
        photo: Qt.resolvedUrl("IDPhoto_LifterSam.png") // WICHTIG: im cmake muss Foto angegeben werden unter RESSOURCES
        occupation: "QML Programmer"
        company: "(Mi)³ Management"
        address: "Straße der Freundschaft 69"
        country: "Germany"
        phone: "+49 0815 420 1337"
        email: "LifterSam@mi.com"
        webSite: Qt.url("https://github.com/LifterSam/QML_ID_Card")
    }

    Rectangle {
        id: borderRectangle    // Das äußere Rechteck, das als Rahmen dient; alles hier verankert
        anchors {
            fill: parent       // Das Rechteck füllt das übergeordnete Element komplett aus
            margins: 5         // Lässt einen 5px Abstand zu den Rändern des Eltern-Elements
        }

        gradient: Gradient {   // Gradient geht nur vertikal; lieber Bildhintergrund nehmen
            GradientStop {
                position: 0.0  // Immer y-Position wird hier angegeben
                color: "white" // Start ist oben wie beim CRT Monitor
            }
            GradientStop {
                position: 1.0  // 1.0 heißt y-Achse komplett ausgenutzt (100 %) d.h. bis unten
                color: "grey"
            }
        }

        border {
            color: "black"     // Rahmenfarbe ist schwarz
            width: 3           // Rahmenbreite ist 3 Pixel
        }
        radius: 10             // Abgerundete Ecken mit einem Radius von 10 Pixeln

        Rectangle {
            id: imageFrame      // Inneres Rechteck, das den Rahmen für das Bild bildet
            width: 200          // Feste Breite von 200 Pixeln
            height: 200         // Feste Höhe von 200 Pixeln
            anchors.top: parent.top     // Das Rechteck wird oben am übergeordneten Element ausgerichtet
            anchors.right: parent.right // Das Rechteck wird rechts am übergeordneten Element ausgerichtet
            anchors.margins: 5          // Abstand von 5 Pixeln nach oben und rechts
            color: "transparent"        // Hintergrund ist durchsichtig
            border.color: "black"       // Der Rahmen dieses Rechtecks ist ebenfalls schwarz
            border.width: 2             // Rahmenbreite beträgt 2 Pixel
            radius: 5                   // Abgerundete Ecken mit einem Radius von 5 Pixeln

            Image {
                source: "IDPhoto_LifterSam.png"
                anchors.fill: parent              // Das Bild füllt das gesamte `imageFrame`-Rechteck aus
                anchors.margins: 5                // Sorgt für einen Abstand von 5 Pixeln zwischen Bild und `imageFrame`
                fillMode: Image.PreserveAspectFit // Bild wird skaliert, sodass es proportional bleibt und in den Frame passt
            }
        }

        Text {
            id: name         // Dieses Feld ist immer sichtbar auch bei Button Toggle Aktion
            text: myContactInfo.name
            anchors.top: borderRectangle.top
            anchors.left: borderRectangle.left
            anchors.topMargin: 10
            anchors.leftMargin: 25
            font.pixelSize: 40
            font.bold: true
            color: "black"
        }

        Text {
            id: erscheinungsjahr
            text: "©T.E. 1993" // ein Scherz, weil das Design der Karte aussieht wie aus den 90ern
            anchors.bottom: borderRectangle.bottom
            anchors.right: borderRectangle.right
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            font.pixelSize: 15
            font.bold: true
        }

        // Initiale Textfelder vor Button Swap =====================================================
        Text {
            id: occupation
            visible: true              // Beim Aufruf der Karte ist dieses Feld sichtbar
            text: myContactInfo.occupation
            anchors.top: name.bottom
            anchors.left: name.left
            anchors.topMargin: 10
            font.pixelSize: 30
            font.bold: false          // Kann auch weggelassen werden, hier nur als Beispiel
            color: "black"
        }

        Text {
            id: company
            visible: true
            text: myContactInfo.company
            anchors.top: occupation.bottom
            anchors.left: occupation.left
            anchors.topMargin: 10
            font.pixelSize: 30
            color: "black"
        }

        // Textfelder bei Button Swap ==============================================================
        Text {
            id: address
            visible: false              // Beim Aufruf der Karte ist dieses Feld nicht-sichtbar
            text: myContactInfo.address // Befindet sich aber auf selber Ebene
            anchors.top: name.bottom
            anchors.left: name.left
            anchors.topMargin: 10
            font.pixelSize: 25
            color: "black"
        }

        Text {
            id: country
            visible: false
            text: myContactInfo.country
            anchors.top: address.bottom
            anchors.left: address.left
            anchors.topMargin: 10
            font.pixelSize: 25
            color: "black"
        }

        Text {
            id: phone
            visible: false
            text: myContactInfo.phone
            anchors.top: country.bottom
            anchors.left: country.left
            anchors.topMargin: 10
            font.pixelSize: 20
            color: "black"
        }

        Text {
            id: email
            visible: false
            text: myContactInfo.email
            anchors.top: phone.bottom
            anchors.left: phone.left
            anchors.topMargin: 10
            font.pixelSize: 20
            color: "black"
        }

        Text {
            id: webSite
            visible: false
            text: myContactInfo.webSite
            anchors.top: email.bottom
            anchors.left: email.left
            anchors.topMargin: 10
            font.pixelSize: 20
            color: "black"

            // Mit Click die Homepage öffnen können ==============================================
            MouseArea { // Einrückung zeigt, die MouseArea gehört zum Textfeld der webSite
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // Öffnet die URL im Standard-Browser
                    Qt.openUrlExternally("https://github.com/LifterSam/QML_ID_Card")
                }
            }
        }


        // Button besteht aus Textfeld mit Event Handling ========================================
        Rectangle {
            id: button
            width: 130
            height: 50
            anchors.bottom: borderRectangle.bottom
            anchors.left: borderRectangle.left
            anchors.bottomMargin: 20
            anchors.leftMargin: 20
            color: "grey"
            radius: 10
            border.color: "black"
            border.width: 1

            Text {
                id: buttonText
                anchors.centerIn: parent
                text: "Details"
                font.pixelSize: 20
                font.bold: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Button wurde geklickt!")

                    // Toggle zwischen General und Details
                    if (buttonText.text === "Details") { // Bedingung gitl für Moment, in welchem Butto geclickt wird (!)
                        // Wenn der Button "Details" zeigt, wechsle zu "General" als Button Text und zeige die Detail Infos
                        occupation.visible = false
                        company.visible = false

                        address.visible = true
                        country.visible = true
                        phone.visible = true
                        email.visible = true
                        webSite.visible = true

                        buttonText.text = "General"
                        buttonText.color = "#616161"
                        button.color = "#bdbdbd"

                    } else {
                        // Wenn der Button "General" zeigt, wechsle zu "Details" als Button Text und zeige General Infos
                        occupation.visible = true
                        company.visible = true

                        address.visible = false
                        country.visible = false
                        phone.visible = false
                        email.visible = false
                        webSite.visible = false

                        buttonText.text = "Details"
                        buttonText.color = "white"
                        button.color = "grey"
                    }
                }
            }
        }
    }
}
