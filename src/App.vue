<template>
  <div id="app">
    <header>
      <div class="title">{{title}}</div>
    </header>

    <section class="main-content w-50 mx-auto">
      <main-navigation @tab-selected="updateSelectedTab"></main-navigation>
      <component :is="selectedTabComponent"></component>
    </section>
  </div>
</template>

<script>
import MainNavigation from './components/MainNavigation.vue';
import WindowsList from './components/WindowsList.vue';
import RoomsList from './components/RoomsList.vue';

export default {
  name: 'App',
  components: {
    MainNavigation,
    WindowsList,
     RoomsList,
  },
  data() {
    return {
      title: 'My App Title',
      selectedTab: 'windows',
    };
  },
computed: {
    selectedTabComponent() {
      return this.selectedTab === 'rooms' ? 'RoomsList' : 'WindowsList';
    },
  },
  methods: {
    updateSelectedTab(tab) {
      this.selectedTab = tab;
    },
  },

};
</script>

<style lang="scss" scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

</style>
