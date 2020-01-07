<template>
  <div id="tree">
    <treeview 
      class="treeview" 
      v-for="(t, i) in tree" 
      :text.sync="t.text" 
      :nodes.sync="t.nodes" 
      :type.sync="t.type" 
      :link.sync="t.link" 
      :closed="icons.closed" 
      :opened="icons.opened" 
      :defaultIcon="icons.default" 
      :editable="editable" 
      :draggable="draggable"
      :key="i"
      ></treeview>
    <p>Double click to create new node</p>
  </div>
</template>

<script>
import branch from './branch'

export default {
  name: 'TreeView',
  props: {
    tree: {
      type: Array,
      required: true,
      default: () => []
    },
    icons: {
      type: Object,
      default: () => ({
        closed: "plus-square",
        opened: "minus-square",
        default: "truck-loading"
      })
    },
    editable: {
      type: Boolean,
      default: () => true
    },
    draggable: {
      type: Boolean,
      default: () => true
    }
  },
  components: {
    treeview: branch
  }
}
</script>

<style scoped>#tree {
  background-color: #36404a;
  padding: 20px;
  border: none;
  border-radius: 10px;
  box-shadow: 2px 2px 7px 3px #36404a;
}
#tree .treeview {
  font-weight: Bold;
}
#tree .treeview >>> li > ul.first li:before {
  display: block;
}
#tree .treeview >>> ul.last li:after {
  display: none;
}
#tree .treeview >>> ul li {
  position: relative;
}
#tree .treeview >>> ul li:after {
  position: absolute;
  content: "";
  top: 9px;
  left: -15px;
  border-left: 2px dashed #607d8b;
  border-top: 2px dashed #607d8b;
  border-radius: 5px 0 0 0;
  width: 13px;
  height: 89%;
}
#tree .treeview >>> ul li:before {
  content: "";
  position: absolute;
  top: -6px;
  left: -15px;
  border-left: 2px dashed #607d8b;
  border-bottom: 2px dashed #607d8b;
  border-radius: 0 0 0 5px;
  width: 13px;
  height: 15px;
}
#tree p {
  font-size: 12px;
  font-style: italic;
}
</style>
