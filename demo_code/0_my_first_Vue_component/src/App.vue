<template>
  <div id="app">
    <header>
      <div class="title">{{title}}</div>
      <input v-model="title">

      <!-- <message :content="'hello'"></message> -->

    </header>
  </div>
</template>

<script>
// import Message from './Message.vue';

export default {
  name: 'App',
  data: function () {
    return {
      title: 'Hello'
    }
  }
  // components: {
  //   Message
  // },
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
</style>
