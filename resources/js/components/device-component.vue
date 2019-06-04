<template>
    <tree-view :tree="tree" />
</template>
<script>
  import TreeView from '@ll931217/vue-treeview'

  export default {
    components: {
      TreeView
    },
    data () {
      return {
      }
    },

    computed: {
      tree() {
        return this.$store.state.test;
      }
    },

    methods: {
      onDel (node) {
        console.log(node)
        node.remove()
      },

      onChangeName (params) {
        console.log(params)
      },

      onAddNode (params) {
        if(params.children && params.children.length == params.parent.max_wires){
          console.log('maximum wires');
          return false;
        }
        console.log(params)
      },

      onClick (params) {
        console.log(params)
      },

      addNode () {
        var node = new TreeNode({ name: 'новый шлейф', isLeaf: false })
        if (!this.data.children) this.data.children = []
        this.data.addChildren(node)
      },

      getNewTree () {
        var vm = this
        function _dfs (oldNode) {
          var newNode = {}

          for (var k in oldNode) {
            if (k !== 'children' && k !== 'parent') {
              newNode[k] = oldNode[k]
            }
          }

          if (oldNode.children && oldNode.children.length > 0) {
            newNode.children = []
            for (var i = 0, len = oldNode.children.length; i < len; i++) {
              newNode.children.push(_dfs(oldNode.children[i]))
            }
          }
          return newNode
        }

        vm.newTree = _dfs(vm.data)
      },

      onClick(model) {
        console.log(model)
      }
    }
  }
</script>
<style lang="less" rel="stylesheet/less">
  .vtl {
    .vtl-drag-disabled {
      background-color: #d0cfcf;
      &:hover {
        background-color: #d0cfcf;
      }
    }
    .vtl-disabled {
      background-color: #d0cfcf;
    }
  }
</style>

<style lang="less" rel="stylesheet/less" scoped>
  .icon {
    &:hover {
      cursor: pointer;
    }
  }
</style>