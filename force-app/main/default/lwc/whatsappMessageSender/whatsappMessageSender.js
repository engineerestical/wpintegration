import { getRecord } from "lightning/uiRecordApi";
import { LightningElement, track, wire, api } from 'lwc';
import sendMessage from '@salesforce/apex/WpTwilioService.sendMessage';

const fields = ['Lead.MobilePhone'];

export default class WhatsappMessageSender extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    lead;

    @track message = '';
    @track messageHistory = [];

    handleMessageChange(event) {
        this.message = event.target.value;
    }
    async sendMessage() {
        if (this.lead.data && this.lead.data.fields.MobilePhone.value) {
            const mobileNumber = this.lead.data.fields.MobilePhone.value;

            if (this.message) {
                try {
                    await sendMessage({ mobileno: mobileNumber, message: this.message });
                    this.messageHistory.unshift({
                        id: Date.now(),
                        message: this.message,
                        timestamp: new Date().toLocaleString()
                    });
                    this.message = '';
                } catch (error) {
                    console.error('Error sending message:', error);
                }
            }
        } else {
            console.warn('Lead data or mobile number is not available.');
        }
    }
}
