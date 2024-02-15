<template>
  <div>
    <div v-for="room in rooms" :key="room.id" class="border border-secondary rounded p-2 mb-2">
      <div class="top-row d-flex">
        <div class="fw-bold pe-3">{{ room.name }}</div>
        <div class="text-muted">Floor {{ room.floor }}</div>
      </div>
      <hr />

      <div v-for="window in room.windows" :key="window.id" class="border border-secondary rounded p-2 mb-2">
        <div class="top-row d-flex">
          <div class="fw-bold pe-3">{{ window.name }}</div>
          <div class="ms-4">
            <span v-if="window.windowStatus.value === 1">&#x2B24;</span>
            <span v-else>&#x2716;</span> {{ window.windowStatus.value === 1 ? 'Open' : 'Closed' }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { API_HOST } from '../config';

export default {
  name: 'RoomsList',
  data() {
    return {
      rooms: [],
    };
  },
  mounted() {
    this.loadRooms();
  },
  methods: {
    async loadRooms() {
      try {
        const response = await axios.get(`${API_HOST}/api/rooms`);
        this.rooms = response.data;
      } catch (error) {
        console.error('Error fetching rooms:', error);
      }
    },
  },
};
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
