public class TwilioCalloutHelper {
    @future(callout=true)
    public static void sendMessageAsync(String mobileno, String message) {
        WpTwilioService.sendMessage(mobileno, message);
    }
}
