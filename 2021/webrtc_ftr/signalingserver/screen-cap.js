"user strict";

const mediaStreamConstraints = {
  video: true
};

const localScreen = document.getElementById("local-video");

function gotLocalMediaStream(mediaStream) {
  const localStream = mediaStream;
  localScreen.srcObject = mediaStream;
}

function handleLocalMediaStreamError(error) {
  console.log("navigator.getUserMedia error: ", error);
}

navigator.mediaDevices
  .getDisplayMedia(mediaStreamConstraints)
  .then(gotLocalMediaStream)
  .catch(handleLocalMediaStreamError);
