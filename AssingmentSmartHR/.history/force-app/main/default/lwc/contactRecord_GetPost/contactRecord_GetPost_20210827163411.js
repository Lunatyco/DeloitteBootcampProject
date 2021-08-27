import { LightningElement } from 'lwc';

export default class ContactRecord_GetPost extends LightningElement {
    ObtainPosts() {
        fetchPosts({}).then(
            response => {
                //this.strUrl = JSON.parse(response).message;
            }).catch(error => {
            console.log('Error: ' + error.body.message);
        })
    }
}