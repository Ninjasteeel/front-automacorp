<template>
    <div class="message">
         {{ content }}
    </div>
</template>
  
<script>
export default {
    name: 'Message',
    props: ['content']
}
</script>
  
<style lang="scss" scoped>
.message {
    background-color: lightgray;
    width: 100px;
    border-radius: 10px;
}
</style>
  