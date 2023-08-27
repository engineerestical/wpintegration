public class WpTwilioServiceFlow {
    @InvocableMethod(label='Send Twilio Whatsapp Message From Flow' description='Sends a WhatsApp message using Twilio')
    public static List<InvocableResult> sendMessage(List<InvocableRequest> requests) {
        List<InvocableResult> results = new List<InvocableResult>();

        for (InvocableRequest request : requests) {
            String mobileno = request.mobileno;
            String message = request.message;

            if (mobileno != null) {
                TwilioCalloutHelper.sendMessageAsync(mobileno, message);
                results.add(new InvocableResult(true, 'Message sending initiated for ' + mobileno));
            } else {
                results.add(new InvocableResult(false, 'Mobile number is required'));
            }
        }

        return results;
    }

    public class InvocableRequest {
        @InvocableVariable(required = true)
        public String mobileno;
        @InvocableVariable(required = true)
        public String message;
    }

    public class InvocableResult {
        @InvocableVariable
        public Boolean isSuccess;
        @InvocableVariable
        public String message;

        public InvocableResult(Boolean isSuccess, String message) {
            this.isSuccess = isSuccess;
            this.message = message;
        }
    }
}
