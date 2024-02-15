<template>
  <div>
    <div v-if="!isCreationFormVisible">
      <div class="window border border-secondary rounded p-2 mb-2" :class="{ expanded: isExpanded }">
        <div class="top-row d-flex" @click="toggleExpand">
          <div class="window-name fw-bold pe-3">{{ window.name }}</div>
          <div class="room-name text-muted">{{ window.roomName }}</div>
          <div class="open-status ms-4" :class="{ open: isWindowOpen, closed: !isWindowOpen }">
            <template v-if="isWindowOpen">
              <span class="icon">&#x2B24;</span> Open
            </template>
            <template v-else>
              <span class="icon">&#x2716;</span> Closed
            </template>
          </div>
          <div class="expand-button ms-auto">{{ isExpanded ? '&#9660;' : '&#9658;' }}</div>
        </div>
        <template v-if="isExpanded">
          <hr />
          <div class="details d-flex">
            <button type="button" class="btn btn-secondary me-2" @click="switchWindow">
              {{ isWindowOpen ? 'Close' : 'Open' }} window
            </button>
            <button type="button" class="btn btn-danger" @click="showDeleteConfirmation">Delete window</button>
          </div>
        </template>
      </div>
    </div>
    <div v-else>
      <window-creation-form
        @cancel="cancelCreationForm"
        @create="createWindow"
        :rooms="rooms"
      />
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { API_HOST } from '../config';
import WindowCreationForm from './WindowCreationForm.vue';

export default {
  name: 'WindowsListItem',
  components: {
    WindowCreationForm
  },
  props: ['window'],
  data() {
    return {
      isExpanded: false,
      isDeleteConfirmationVisible: false,
      deleteConfirmationMessage: '',
      isCreationFormVisible: false,
      rooms: []
    };
  },
  computed: {
    isWindowOpen() {
      return this.window.windowStatus.value === 1;
    },
  },
  methods: {
    toggleExpand() {
      this.isExpanded = !this.isExpanded;
    },
    async switchWindow() {
      try {
        let newWindowStatus = this.window.windowStatus.value === 1 ? 0 : 1;
        let jsonPayload = {
          name: this.window.name,
          windowStatus: {
            name: this.window.windowStatus.name,
            value: newWindowStatus,
            sensorType: this.window.windowStatus.sensorType
          }
        };
        let response = await axios.put(`https://myapi.cleverapps.io/api/windows/${this.window.id}`, jsonPayload);
        let updatedWindow = response.data;
        this.$emit('window-updated', updatedWindow);
      } catch (error) {
        console.error('Error updating window status:', error);
      }
    },
    showDeleteConfirmation() {
      this.deleteConfirmationMessage = `Are you sure you want to delete ${this.window.name}?`;
      this.isDeleteConfirmationVisible = true;
    },
    confirmDeleteWindow() {
      this.isDeleteConfirmationVisible = false;
      this.deleteWindow();
    },
    cancelDeleteWindow() {
      this.isDeleteConfirmationVisible = false;
    },
    async deleteWindow() {
      try {
        const response = await axios.delete(`https://myapi.cleverapps.io/api/windows/${this.window.id}`);
        location.reload();
        this.$emit('window-deleted', this.window.id);
      } catch (error) {
        console.error('Error deleting window:', error);
      }
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
    async createWindow(newWindow) {
      try {
        const jsonPayload = {
          name: newWindow.name,
          windowStatus: {
            name: newWindow.windowStatus.name,
            value: newWindow.windowStatus.value,
            sensorType: newWindow.windowStatus.sensorType,
          },
          roomId: newWindow.roomId,
        };
        const response = await axios.post(`${API_HOST}/api/windows`, jsonPayload);
        const createdWindow = response.data;
        this.$emit('window-created', createdWindow);
        this.isCreationFormVisible = false;
      } catch (error) {
        console.error('Error creating window:', error);
      }
    },
  }
}
</script>

<style lang="scss" scoped>
.open-status {
  .icon {
    position: relative;
  }

  &.open {
    color: #198754;
    .icon {
      font-size: 12px;
      top: -3px;
    }
  }

  &.closed {
    color: #dc3545;
  }
}

.window {
  .top-row {
    cursor: pointer;
  }
}

.modal-background {
  position: fixed;
  background-color: rgba(0, 0, 0, 0.3);
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}
</style>
