<template>
  <ul class="nav nav-tabs">
    <li class="nav-item" @click="selectTab('windows')">
      <a class="nav-link" :class="{ active: selectedTab === 'windows' }" href="#">Windows</a>
    </li>
    <li class="nav-item" @click="selectTab('rooms')">
      <a class="nav-link" :class="{ active: selectedTab === 'rooms' }" href="#">Rooms</a>
    </li>
  </ul>
  <div v-if="!isCreationFormVisible">
      <button class="btn btn-primary" @click="showCreationForm">Create new window</button>
      </div>
<div v-else>
      <window-creation-form
        @cancel="cancelCreationForm"
        @create="createWindow"
        :rooms="rooms"
      />    </div>

</template>


<script>
import axios from 'axios';
import { API_HOST } from '../config';
import WindowCreationForm from './WindowCreationForm.vue';

export default {
  name: 'MainNavigation',
  components: {
    WindowCreationForm

  },
  data() {
    return {
      selectedTab: 'windows',
      isCreationFormVisible: false,
      rooms: []
    };
  },
  methods: {
    selectTab(tab) {
      this.selectedTab = tab;
      this.$emit('tab-selected', tab);
    },
    showCreationForm() {
      this.isCreationFormVisible = true;
      this.loadRooms();
    },
    cancelCreationForm() {
      this.isCreationFormVisible = false;
    },
    async loadRooms() {
      try {
        const response = await axios.get(`${API_HOST}/api/rooms`);
        this.rooms = response.data;
      } catch (error) {
        console.error('Error fetching rooms:', error);
      }
    },
    async createWindow() {
  try {
    // Validate form fields before sending the request
    console.log('Creating window with:', {
      name: this.newWindowName,
      windowStatus: {
       name: 'Window 3 status room 2', // You may need to adjust this based on your data model
        value: 0,       // You may need to adjust this based on your data model
        sensorType: 'STATUS',
        id:-11, // You may need to adjust this based on your data model
      },
      roomId: this.selectedRoom,
    });

    const jsonPayload = {
      name: this.newWindowName,
      windowStatus: {
        name: 'Window 3 status room 2', // You may need to adjust this based on your data model
        value: 0,       // You may need to adjust this based on your data model
        sensorType: 'STATUS',
        id:-7, // You may need to adjust this based on your data model
      },
      roomId: this.selectedRoom,
    };
location.reload();
    // Send request to create window
    const response = await axios.put(`https://myapi.cleverapps.io/api/windows/-10`, jsonPayload);
    const createdWindow = response.data;

    // If successful, emit event to parent component
    this.$emit('create', createdWindow);
     location.reload();
    // Reset the form and hide the creation form
    this.resetForm();
  } catch (error) {
    console.error('Error creating window:', error);
    this.creationError = 'An unexpected problem occurred, and the window could not be created.';
  }
},
  }
}
</script>

<style>
/* Add your styles here if needed */
</style>
