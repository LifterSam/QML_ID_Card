import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: width / 1.586
    visible: true
    title: qsTr("Business Card")

    color: "white"

    component ContactInfo: QtObject {

        // those properties are always visible
        property string name
        property url photo

        // general properties:
        property string occupation
        property string company

        // detailed properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }

    ContactInfo {
        id: myContactInfo

        name: "LifterSam"
        photo: Qt.resolvedUrl("IDPhoto_LifterSam.png") // needs to be included in cmake (!)
        occupation: "QML Programmer"
        company: "(Mi)³ Management"
        address: "Straße der Freundschaft 69"
        country: "Germany"
        phone: "+49 0815 420 1337"
        email: "LifterSam@mi.com"
        webSite: Qt.url("https://github.com/LifterSam/QML_ID_Card")
    }

    Rectangle {
        id: borderRectangle    
        anchors {
            fill: parent      
            margins: 5         
        }

        gradient: Gradient {   
            GradientStop {
                position: 0.0  
                color: "white" 
            }
            GradientStop {
                position: 1.0  
                color: "grey"
            }
        }

        border {
            color: "black"     
            width: 3           
        }
        radius: 10             

        Rectangle {
            id: imageFrame      
            width: 200          
            height: 200         
            anchors.top: parent.top     
            anchors.right: parent.right 
            anchors.margins: 5          
            color: "transparent"        
            border.color: "black"       
            border.width: 2             
            radius: 5                   

            Image {
                source: "IDPhoto_LifterSam.png"
                anchors.fill: parent              
                anchors.margins: 5                
                fillMode: Image.PreserveAspectFit 
            }
        }

        Text {
            id: name         // this field is always visible, even with button toggle action
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
            text: "©T.E. 1993" // a joke because the design of the card looks like it's from the '90s
            anchors.bottom: borderRectangle.bottom
            anchors.right: borderRectangle.right
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            font.pixelSize: 15
            font.bold: true
        }

        // initial text field before button swap ====================================================
        Text {
            id: occupation
            visible: true              // at first call this field is visible
            text: myContactInfo.occupation
            anchors.top: name.bottom
            anchors.left: name.left
            anchors.topMargin: 10
            font.pixelSize: 30
            font.bold: false          // can be omitted, only shown as example
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

        // text fields at button swap ==============================================================
        Text {
            id: address
            visible: false              // at first call this field is invisible
            text: myContactInfo.address 
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

            // how to open homepage with click on text ============================================
            MouseArea { 
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // next line opens URL in system standard browser
                    Qt.openUrlExternally("https://github.com/LifterSam/QML_ID_Card")
                }
            }
        }


        // button is build from text field with event handler ====================================
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
                    console.log("Button was clicked!")

                    // toggle between general and details
                    if (buttonText.text === "Details") { // condition applies to the moment in which the button is clicked (!)
                        // if the button shows 'Details,' change the button text to 'General' and display the detailed information
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
                        // if the button shows 'General,' change the button text to 'Details' and display the general information
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
