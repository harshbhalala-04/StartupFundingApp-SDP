const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { response } = require("express");
admin.initializeApp();
const db = admin.firestore();
const fieldValue = admin.firestore.FieldValue;


exports.onStartupUpdate = functions.firestore
    .document("/Startups/{startupId}")
    .onUpdate(async (snapshot, context) => {
        try{
            const oldStartupData = snapshot.before.data();
            const newStartupData = snapshot.after.data();

            if(oldStartupData["latestConnectionSentUid"] != newStartupData["latestConnectionSentUid"]) {
                const investorRef = db.collection("Investors").doc(newStartupData["latestConnectionSentUid"]);
                const investorData = await investorRef.get();
                const tokens = [];

                if(investorData.data()["notificationTokens"] != undefined && investorData.data()["notificationTokens"].length != 0) {
                    investorData.data()["notificationTokens"].forEach((token) => {
                        tokens.push(token);
                    });
                }

                const payLoadData = {
                    click_action: "FLUTTER_NOTIFICATION_CLICK",
                    title: "You have recieved a request",
                    message: "Tap to view",
                    screen: "Investor_Feed_Screen"
                };
                const payLoad = {
                    data: payLoadData,
                };
                await admin.messaging()
                    .sendToDevice(tokens, payLoad)
                    .then((response) => {
                        console.log("Push startup request notification")
                    })
                    .catch((error) => {
                        console.log(error);
                });
            }
            return "Startup updated successfully.";
        }catch(e) {
            console.log(e);
            return "Error";
        }
    });


    exports.onInvestorUpdate = functions.firestore
    .document("/Investors/{investorId}")
    .onUpdate(async (snapshot, context) => {
        try{
            const oldInvestorData = snapshot.before.data();
            const newInvestorData = snapshot.after.data();

            if(oldInvestorData["latestConnectionSentUid"] != newInvestorData["latestConnectionSentUid"]) {
                const startupRef = db.collection("Startups").doc(newInvestorData["latestConnectionSentUid"]);
                const startupData = await startupRef.get();
                const tokens = [];

                if(startupData.data()["notificationTokens"] != undefined && startupData.data()["notificationTokens"].length != 0) {
                    startupData.data()["notificationTokens"].forEach((token) => {
                        tokens.push(token);
                    });
                }

                const payLoadData = {
                    click_action: "FLUTTER_NOTIFICATION_CLICK",
                    title: "You have recieved a request",
                    message: "Tap to view",
                    screen: "Startup_Feed_Screen"
                };
                const payLoad = {
                    data: payLoadData,
                };
                await admin.messaging()
                    .sendToDevice(tokens, payLoad)
                    .then((response) => {
                        console.log("Push startup request notification")
                    })
                    .catch((error) => {
                        console.log(error);
                });
            }
            return "Startup updated successfully.";
        }catch(e) {
            console.log(e);
            return "Error";
        }
    });
