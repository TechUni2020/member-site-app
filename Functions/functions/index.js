const axios = require('axios')  
const functions = require('firebase-functions') 
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore(); 

exports.commentPost = functions.firestore  
  .document('questions/{questionId}')  
  .onCreate(async (snap, context) => {  
    // change内に登録されたデータ内容が入る  
    const commentData = snap.data()  

    // 投稿文字列の作成。`\n`を挟むことで改行ができるので、配列を作成しておく。  
    const array = [  
      `新しい質問が届きました！`,    
      `タイトル: ${commentData.title}`,  
      `使用技術: ${commentData.technology}`,
      `開発環境: ${commentData.environment}`,
      `質問内容: ${commentData.comment}`,
    ]  

    // slack APIが受け取れるオブジェクトを作成する  
    const data = {  
      text: array.join('\n'), // 配列を`\n`で結合、改行する  
      icon_emoji: ':ghost:',  
      username: 'Tech.Uni伝書鳩',  
      channel: '#質問'  
    }  

    // slack APIに送信する  
    await axios.post('https://hooks.slack.com/services/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', data) 
    functions.logger('ええええええええ') 
  })  