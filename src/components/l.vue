<template>
  <div class="window border border-secondary rounded p-2 mb-2" :class="{expanded: isExpanded}">
    <div class="top-row d-flex" @click="toggleExpand">
      <div class="window-name fw-bold pe-3">{{window.name}}</div>
      <div class="room-name text-muted">{{window.roomName}}</div>

      <div class="open-status ms-4" :class="{open: isWindowOpen, closed: !isWindowOpen}">
        <template v-if="isWindowOpen">
          <span class="icon">&#x2B24;</span> Open
        </template>
        <template v-else>
          <span class="icon">&#x2716;</span> Closed
        </template>
      </div>

      <div class="expand-button ms-auto">
        {{ isExpanded ? '&#9660;' : '&#9658;' }}
      </div>
    </div>
    <template v-if="isExpanded">
      <hr />
      <div class="details d-flex">
        <button type="button" class="btn btn-secondary me-2" @click="switchWindow">
          {{ isWindowOpen ? 'Close' : 'Open' }} window
        </button>
        <button type="button" class="btn btn-danger" @click="showDeleteConfirmation">Delete window</button>
      </div>

      <!-- Confirmation modal -->
      <div v-if="isDeleteConfirmationVisible" class="modal-background">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-body">
              {{ deleteConfirmationMessage }}
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="cancelDeleteWindow">Close</button>
              <button type="button" class="btn btn-danger" @click="confirmDeleteWindow">Confirm</button>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import axios from 'axios';
import { API_HOST } from '../config';

export default {
  name: 'WindowsListItem',
  props: ['window'],
  data: function () {
    return {
      isExpanded: false,
      isDeleteConfirmationVisible: false,
      deleteConfirmationMessage: '',
    };
  },
  computed: {
    isWindowOpen: function () {
      return this.window.windowStatus.value === 1; // Updated to check windowStatus.value
    },
  },
  methods: {
    toggleExpand() {
      this.isExpanded = !this.isExpanded;
    },
    async switchWindow() {
      // Existing code...
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
        const response = await axios.delete(`${API_HOST}/api/windows/${this.window.id}`);
        this.$emit('window-deleted', this.window.id);
      } catch (error) {
        console.error('Error deleting window:', error);
        // Handle the error (e.g., show a notification to the user)
      }
    },
  },
};
</script>

<style lang="scss" scoped>
/* Existing styles... */
.modal-background {
  position: fixed;
  background-color: rgba(0, 0, 0, 0.3);
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}
</style>
