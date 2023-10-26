<template>
  <div id="app">

    <button class="btn btn-primary open-menu-btn" v-if="!isMenuOpen" @click="toggleMenu">Open</button>
    <button class="btn btn-danger close-menu-btn" v-if="isMenuOpen" @click="toggleMenu">Close</button>


    <ul class="list-group menu" v-if="isMenuOpen">
      <li class="list-group-item">Home</li>
      <li class="list-group-item">About</li>
    </ul>

  </div>
</template>

<script>
export default {
  name: 'App',
  data: function () {
    return {
      isMenuOpen: false
    }
  },
  methods: {
    toggleMenu() {
      this.isMenuOpen = !this.isMenuOpen;
    }
  }
}
</script>

<style lang="scss" scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
  margin-left: 100px;
}

.menu {
  width: 200px;
}

button {
  display: block;
}
</style>
