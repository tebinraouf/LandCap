var web_fireBase={};
(function(){
    // Initialize Firebase
      var config = {
        apiKey: "AIzaSyABo2SdHN27Aw8-jU16NefzScUO9VoHlc0",
        authDomain: "landcap-4b318.firebaseapp.com",
        databaseURL: "https://landcap-4b318.firebaseio.com",
        projectId: "landcap-4b318",
        storageBucket: "landcap-4b318.appspot.com",
        messagingSenderId: "97215581986"
      };
      firebase.initializeApp(config);
    
    web_fireBase = firebase;
})()
      
    


firebase.auth().onAuthStateChanged(function(user) {
  if (user) {
    // User is signed in.
  } else {
    // No user is signed in.
  }
});

function login(){
var userEmail = document.getElementById("emailForm").value;
    
var userPassword = document.getElementById("passwordForm").value;
    
window.alert(userEmail + "\n" + userPassword);
}