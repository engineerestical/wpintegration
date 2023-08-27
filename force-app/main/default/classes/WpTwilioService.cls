public class WpTwilioService {
    @AuraEnabled
    public static void sendMessage(String mobileno, String message)
    {
        errorResponseWrapper erw;
        final String fromNumber = '+14155238886'; //Your Twilio Number
        String account = 'ACeb7a9d7f58720f6ee84f9909f8010601';  // Your Account SID 
        String token   = 'c6c4f0b8914802d80ffeb7ebaf087165'; // Your Auth Token
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+account+'/Messages.json');
        req.setMethod('POST'); 
        req.setHeader('Content-Type','application/json');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(account + ':' + token);
        String authorizationHeader = 'BASIC ' +
            EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        
        
        if(mobileno != null)
        {
            string jsonString='From='+EncodingUtil.urlEncode('whatsapp:+14155238886', 'UTF-8')+'&Body='+EncodingUtil.urlEncode(message, 'UTF-8')+'&To='+EncodingUtil.urlEncode('whatsapp:'+mobileno+'', 'UTF-8')+'';
            req.setBody(jsonString);
            try{
                Http http = new Http();
                HTTPResponse res = http.send(req);
                System.debug(res.getBody());
                if(res.getStatusCode()==201)
                    system.debug('Twilio Success'+mobileno);
                else{
                    system.debug('Twilio failed'+mobileno);
                    erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
                    system.debug('Twilio error'+erw.message);
                }
            }
            catch(Exception e){
                system.debug('Error :'+e);
            } 
            
        }
    }
    public class errorResponseWrapper{
        String code;
        String message;
        String moreInfo;
        String status;    
    }
}