import { LightningElement } from 'lwc';

export default class ContactRecord_GetPost extends LightningElement {
    gridColumns = [{
            type: 'number',
            fieldName: 'userId',
            label: 'User ID'
        },
        {
            type: 'number',
            fieldName: 'id',
            label: 'ID'
        },
        {
            type: 'text',
            fieldName: 'title',
            label: 'Title'
        },
        {
            type: 'text',
            fieldName: 'body',
            label: 'Body'
        }
    ];
    gridData;


}