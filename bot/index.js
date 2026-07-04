
const {Client,GatewayIntentBits,ActivityType}=require('discord.js');
const express=require('express');
const app=express();
const client=new Client({intents:[GatewayIntentBits.Guilds,GatewayIntentBits.GuildMembers,GatewayIntentBits.GuildMessages,GatewayIntentBits.MessageContent]});
const OWNER='909359845872922635';
client.once('ready',()=>{
 console.log(`Logged in as ${client.user.tag}`);
 client.user.setPresence({status:'dnd',activities:[{type:ActivityType.Listening,name:'Hermas Collective Game Data'}]});
});
client.on('messageCreate',m=>{
 if(m.author.bot) return;
 if(m.mentions.has(client.user))
   m.reply(`Hey there <@${m.author.id}>! Sorry xFranki_ee has not updated my talking capabilities yet, I hope to see you ingame!`);
});
app.get('/api/player/:id',(req,res)=>{
 res.json({robloxId:req.params.id,level:0,roles:[],displayName:'Unknown',username:'Unknown'});
});
app.listen(3000,()=>console.log('API running'));
client.login(process.env.BOT_TOKEN);
