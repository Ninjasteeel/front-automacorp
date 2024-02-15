<template>
  <div class="windows-list pt-3">
    <windows-list-item 
      v-for="window in windows"
      :window="window"
      :key="window.id"  
      @window-updated="updateWindow"
    >
    </windows-list-item>
  </div>
</template>

<script>
import axios from 'axios';
import WindowsListItem from './WindowsListItem.vue';

export default {
  components: {
    WindowsListItem
  },
  name: 'WindowsList',
  data: function() {
    return {
      windows: []
    }
  },
 async created() {
    try {
      const response = await axios.get('http://localhost:8085/api/windows', {
        auth: {
          username: 'user',
          password: 'password'
        }
      }); 
      console.log(response);
      const windows = response.data;
      this.windows = windows;
    } catch (error) {
      console.error('Error fetching windows:', error);
    }
  },

  methods: {
    updateWindow(newWindow) {
      const index = this.windows.findIndex(window => window.id === newWindow.id);
      this.windows.splice(index, 1, newWindow);
    }
  }
}
</script>
