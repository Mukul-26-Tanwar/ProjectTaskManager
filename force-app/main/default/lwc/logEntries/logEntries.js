
import { LightningElement, wire, track } from 'lwc';
import Id from '@salesforce/user/Id';
import USER_NAME from '@salesforce/schema/User.Username';
import FIRST_NAME from '@salesforce/schema/User.FirstName';
import LAST_NAME from '@salesforce/schema/User.LastName';
import { getRecord } from 'lightning/uiRecordApi';
import fetchProjects from '@salesforce/apex/ProjectTaskController.fetchProjects';
import fetchTasks from '@salesforce/apex/ProjectTaskController.fetchTasks';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class LogEntries extends LightningElement {

    userId = Id;
    userName = '';
    @track projectOptions = [];
    @track taskOptions = [];
    selectedProject;
    selectedTask;
    hours = '';
    startDate;                   
    endDate; 

    //getting the user details
    @wire(getRecord, { recordId : "$userId", fields: [USER_NAME, FIRST_NAME, LAST_NAME] })
    user({data, error}){
        if(data){
            this.userName = `${data.fields.FirstName.value} ${data.fields.LastName.value}`;
        } else {
            console.error('Error',error);
        }
    }

    //getting all the projects
    @wire(fetchProjects)
    wiredProjects({ data, error }){
        if(data){
            this.projectOptions = data.map(project => {
                return { label: project.Name, value: project.Id };
            });
        } else if(error){
            console.log('Error: ', error);
        }
    }

    handleProjectChange(event) {
        this.selectedProject = event.detail.value;
        fetchTasks({ projectId: this.selectedProject })
        .then(data => {
            this.taskOptions = data.map(task => {
                return { label: task.Name, value: task.Id };
            });
        }).catch(error => {
            console.log(error);
        })
    }

    handleTaskChange(event) {
        this.selectedTask = event.detail.value;
        console.log(this.selectedTask);
    }

    // Insert record
    // handleSubmit(event){
    //     event.preventDefault();       
    //     const fields = event.detail.fields;

    //     const objectData = {
    //         startTime: fields.Start__c, 
    //         endTime: fields.End__c, 
    //         description: fields.Description__c
    //     };  

    //     console.log('test',JSON.stringify(objectData));
    // }

    handleStartDateChange(event) {
        this.startDate = new Date(event.target.value);
        this.calculateHours();
    }

    handleEndDateChange(event) {
        this.endDate = new Date(event.target.value);
        this.calculateHours();
    }

    calculateHours() {
        if (this.startDate && this.endDate) {
            if (this.endDate > this.startDate) {

                const timeDiff = this.endDate - this.startDate;
                const totalMinutes = Math.floor(timeDiff / (1000 * 60)); 
                const hours = Math.floor(totalMinutes / 60);
                const minutes = totalMinutes % 60;
                this.hours = `${hours} hours ${minutes} minutes`;
            } else {
                this.hours = '';
                this.showToast("Error", "End Date should be greater than Start Date.", "error");
            }
        }
    }

    handleError(event){
        console.log('error'+JSON.stringify(event));
    }

    handleSuccess(event){
        this.showToast("Success", "Logged Successfully", "success");
        // this.reset();
    }
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}