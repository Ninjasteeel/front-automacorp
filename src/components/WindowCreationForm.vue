<template>
  <div>
    <div class="d-flex mb-2">
      <button type="button" class="btn btn-primary me-2" @click="createWindow">Create</button>
      <button type="button" class="btn btn-danger" @click="cancelCreation">Cancel</button>
    </div>

    <div v-if="creationError" class="alert alert-danger" role="alert">
      {{ creationError }}
    </div>

    <form>
      <input v-model="newWindowName" type="text" class="form-control mb-3" placeholder="Window name">
      <select v-model="selectedRoom" class="form-select">
        <option selected>-- Select room --</option>
        <option v-for="room in rooms" :key="room.id" :value="room.id">{{ room.name }}</option>
      </select>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import { API_HOST } from '../config';

export default {
  props: ['rooms'],
  data() {
    return {
      newWindowName: '',
      selectedRoom: null,
      creationError: '',
    };
  },
  methods: {
    cancelCreation() {
      this.$emit('cancel');
      this.resetForm();
    },
    resetForm() {
      this.newWindowName = '';
      this.selectedRoom = null;
      this.creationError = '';
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
        id:-10, // You may need to adjust this based on your data model
      },
      roomId: this.selectedRoom,
    };

    // Send request to create window
    const response = await axios.post(`http://automacorp-boumlik-elkihal.cleverapps.io/api/windows`, jsonPayload);
    const createdWindow = response.data;

    // If successful, emit event to parent component
    this.$emit('create', createdWindow);

    // Reset the form and hide the creation form
    this.resetForm();
  } catch (error) {
    console.error('Error creating window:', error);
    this.creationError = 'An unexpected problem occurred, and the window could not be created.';
  }
},
  },
};
</script>

<style lang="scss" scoped>
/* Add any specific styles for the creation form */
</style>
