import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import fetchPosts from '@salesforce/apex/PostApiController.fetchPosts';

export default class LdsCreateRecord extends LightningElement {
    strTitle;
    strBody;
    strUrl = 'test';

    // Change Handlers.
    titleChangedHandler(event) {
        this.strTitle = event.target.value;
    }
    bodyChangedHandler(event) {
        this.strBody = event.target.value;
    }

    createFetch() {
        fetch('https://jsonplaceholder.typicode.com/posts', {
                method: 'POST',
                body: JSON.stringify({
                    title: this.strTitle,
                    body: this.strBody,
                    userId: 1,
                }),
                headers: {
                    'Content-type': 'application/json; charset=UTF-8',
                },
            })
            .then((response) => response.json())
            .then((json) => {
                console.log(json);
                if (json.body != undefined && json.title != undefined) {
                    alert("Title: " + json.title + "\nBody: " + json.body + "\nUser Id: " + json.userId);
                } else {
                    alert("Insert valid Title and Body.");
                }
            });

    }
    ObtainPosts() {
        fetchPosts({}).then(
            response => {
                //this.strUrl = JSON.parse(response).message;
            }).catch(error => {
            console.log('Error: ' + error.body.message);
        })
    }
}