const {initializeApp, cert} = require("firebase-admin/app");
// const {getStorage} = require("firebase-admin/storage");
const serviceAccount = require(
    "./p4ds-a0e74-firebase-adminsdk-5tp4l-ef9265d951.json");

initializeApp({credential: cert(serviceAccount), storageBucket: "p4ds-a0e74.appspot.com"});
// const bucket = getStorage().bucket();
const functions = require("firebase-functions");
const axios = require("axios");

exports.detectNewHairlineImage = functions.storage.object().onFinalize(async (object) => {
// 업로드된 파일의 경로가 "/user1/Hairline/"로 시작하는지 확인
  if (object.name.startsWith("user1/Hairline/")) {
    const filePath = object.name; // 업로드된 파일 경로
    const bucketName = object.bucket; // 버킷 이름

    // Flask 서버의 REST API 엔드포인트 URL (예시: "http://example.com:5000/notify-upload")
    const flaskEndpoint = "http://35.201.198.18:5000/process-hairline-image";

    try {
      const response = await axios.post(flaskEndpoint, {
        filename: filePath,
        bucket: bucketName,
      });
      console.log("Response from Flask server:", response.data);
    } catch (error) {
      console.error("Error sending request to Flask server:", error);
    }
  }
});

exports.detectNewScalpImage = functions.storage.object().onFinalize(async (object) => {
  // 업로드된 파일의 경로가 "/user1/Scalp/"로 시작하는지 확인
  if (object.name.startsWith("user1/Scalp/")) {
    const filePath = object.name; // 업로드된 파일 경로
    const bucketName = object.bucket; // 버킷 이름

    // Flask 서버의 REST API 엔드포인트 URL (예시: "http://example.com:5000/notify-upload")
    const flaskEndpoint = "http://35.201.198.18:5000/process-scalp-image";

    try {
      const response = await axios.post(flaskEndpoint, {
        filename: filePath,
        bucket: bucketName,
      });
      console.log("Response from Flask server:", response.data);
    } catch (error) {
      console.error("Error sending request to Flask server:", error);
    }
  }
});

exports.userSurveyToRecommender = functions.storage.object().onFinalize(async (object) => {
  // 업로드된 파일의 경로가 "/user1/Scalp/"로 시작하는지 확인
  if (object.name.startsWith("user1/Survey/")) {
    const filePath = object.name; // 업로드된 파일 경로
    const bucketName = object.bucket; // 버킷 이름

    // Flask 서버의 REST API 엔드포인트 URL (예시: "http://example.com:5000/notify-upload")
    const flaskEndpoint = "http://35.201.198.18:5000/process-recommender";

    try {
      const response = await axios.post(flaskEndpoint, {
        filename: filePath,
        bucket: bucketName,
      });
      console.log("Response from Flask server:", response.data);
    } catch (error) {
      console.error("Error sending request to Flask server:", error);
    }
  }
});
