<template>
  <ul>
    <li>
      <transition name="modal">
        <div class="modal-mask" v-show="creating" @click.self="cancel">
          <div class="modal-container">
            <div class="modal-content">
              <h1>Create New Node</h1> 
              <form @keyup.enter="save">
                <input type="text" v-model="newNode.text" placeholder="Text: Google">
                <input type="text" v-model="newNode.link.type" placeholder="Type: link">
                <template v-show="newNode.link.type === 'router-link'">
                  <input type="text" v-model="newNode.link.value" placeholder="Value: https://www.google.com">
                </template>
                
                <div class="btn-group">                  
                  <button type="button" @click="cancel" class="cancel">Cancel</button>
                  <button type="button" @click="save" class="save">Save</button>
                </div>                
              </form>
            </div>
          </div>

        </div>
      </transition>

      <transition name="modal">
        <div class="modal-mask" v-show="editing" @click.self="cancel">
          <div class="modal-container">            
            <div class="modal-content">
              <h1>Edit Node</h1> 
              <form @keyup.enter="save">
                <input type="text" v-model="text" placeholder="Text: Google">
                <input type="text" v-model="link.type" placeholder="Type: link">
                <template v-show="link.type === 'router-link'">
                  <input type="text" v-model="link.key" placeholder="Key: path or name">
                </template>
                  
                <input type="text" v-model="link.value", placeholder="Value: https://www.google.com">
                <div class="btn-group">
                  <button class="cancel" type="button" @click="cancel">Cancel</button> 
                  <button class="save" type="button" @click="edit">Edit</button> 
                </div>
                  
              </form>
                
            </div>
          </div>
        </div>
      </transition>

      <div class="branch" @click="createNewNode" :class="{ link: (nodes.length > 0) }">
        <template v-if="nodes.length > 0">
          <template v-if="open">
            <fa class="minus-square" :icon="opened"></fa>
          </template>            
          <template v-else>
            <fa class="plus-square" :icon="closed"></fa>
          </template>            
          <span>{{ text }}</span> 
        </template>          
        <template v-else-if="link && link.value">
          <router-link class="value" :to="{ [link.key]: link.value }" v-if="link.type === 'router-link'">
            {{ text }}
          </router-link>
          <a class="value" :href="link.value" target="_blank" v-else></a>
            {{ text }}
          <span class="edit" @click="editing = true" v-show="editable">Edit</span> 
        </template>          
        <template v-else>
          <span>{{ text }}</span> 
        </template>          
      </div>       

      <draggable :list="nodes" :group="{ name: 'g1' }" v-if="draggable">
        <branch 
          class="node"
          v-for="(t, i) in nodes"
          :nodes.sync="t.nodes"
          :text="t.text"
          :type="t.type"
          :link="t.link"
          :class="{ open, first: i === 0 && !checkLast(i), last: checkLast(i) }"
          v-if="nodes"
          :closed="closed"
          :opened="opened"
          :defaultIcon="defaultIcon"
          :editable="editable"
          :key="i"
        >          
        </branch>
      </draggable>
      <template v-else>
        <branch 
          class="node"
          v-for="(t, i) in nodes"
          :nodes.sync="t.nodes"
          :text="t.text"
          :type="t.type"
          :link="t.link"
          :class="{ open, first: i === 0 && !checkLast(i), last: checkLast(i) }"
          v-if="nodes"
          :closed="closed"
          :opened="opened"
          :defaultIcon="defaultIcon"
          :editable="editable"
          :key="i"
        >
          
        </branch>
      </template>        
    </li>
  </ul>
</template>

<script>
  import draggable from 'vuedraggable'
  export default {
    name: 'Branch',
    props: {
      text: {
        type: String,
        required: true,
        default: () => ''
      },
      nodes: {
        type: Array,
        default: () => []
      },
      type: {
        type: String,
        default: () => ''
      },
      link: {
        type: Object,
        default: () => ({})
      },
      closed: {
        type: String | Object | Array
      },
      opened: {
        type: String | Object | Array
      },
      defaultIcon: {
        type: String | Object | Array
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
    data: () => ({
      open: false,
      clicks: 0,
      timer: null,
      newNode: {
        text: 'Google',
        link: {
          type: 'link',
          key: '',
          value: 'https://www.google.com'
        }
      },
      creating: false,
      editing: false,
      urlRegex: new RegExp(/^(https?:\/\/)?(www\.|[a-z\d]+\.)?[a-z]+(\.[a-z]{2,3}|:\d{2,5})(\.[a-z]{2,3})?(\/([\w\d]+)?)*((\?|&)[\w\d]+=[\w\d]+)*/)
    }),
    methods: {
      createNewNode () {
        if (this.editable) {
          this.clicks++
          if (this.clicks === 1) {
            const app = this
            this.timer = setTimeout(() => {
              app.toggle()
              app.clicks = 0
            }, 250);
          } else {
            clearTimeout(this.timer)
            this.clicks = 0
            this.creating = true
          }
        } else {
          this.toggle
        }
      },
      cancel () {
        this.creating = false
        this.newNode = {
          text: 'Google',
          link: {
            type: 'link',
            key: '',
            value: 'https://www.google.com'
          }
        }
      },
      edit () {
        this.editing = false
        this.$emit('nodes', this.nodes)
      },
      save () {
        if (this.newNode.link.type === 'link')
          delete this.newNode.link.key
        this.nodes.push(this.newNode)
        this.creating = false
        this.newNode = {
          text: 'Google',
          type: 'link',
          value: 'https://www.google.com'
        }
        this.$emit('nodes', this.nodes)
      },
      toggle () {
        this.open = !this.open
      },
      checkLast (i) {
        return (i + 1) === this.nodes.length
      }
    },
    components: {
      draggable
    }
  }
</script>

<style scoped>
svg {
  margin-right: 0.5em;
}

ul {
  font-weight: bold;
  list-style: none;
  margin: 0;
  padding-left: 20px;
  white-space: nowrap;
}

.branch {
  color: white;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  width: 100%;
}

.minus-square {
  color: orange;
}

.plus-square {
  color: lightgreen;
}

.value {
  color: lightblue;
}

.node {
  height: 0;
  opacity: 0;
  visibility: hidden;
  transition: all 0.5s ease-in-out;
  text-transform: capitalize;
}
.node.open {
  height: 100%;
  opacity: 1;
  visibility: visible;
}

.modal-mask {
  background-color: rgba(0, 0, 0, 0.7);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  transition: opacity 0.3s ease;
}
.modal-mask .modal-container {
  background-color: white;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  cursor: default;
  font-family: Helvetica, Arial, sans-serif;
  margin: 40px auto 0;
  padding: 20px 30px;
  transition: all 0.3s ease;
}
.modal-mask .modal-container .modal-content {
  border-radius: 10px;
  color: black;
  margin: 1em;
  padding: 1em;
  width: 800px;
}
.modal-mask .modal-container .modal-content h1 {
  margin: 0;
}
.modal-mask .modal-container .modal-content form {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  width: 100%;
}
.modal-mask .modal-container .modal-content form input {
  border: 1px solid rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  font-size: 16px;
  font-weight: bold;
  margin: 1em 0;
  padding: 0.2em 0.5em;
  height: 30px;
  width: 100%;
}
.modal-mask .modal-container .modal-content form button {
  background: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  height: 30px;
  width: 80px;
  transition: all 0.3s ease-in-out;
}
.modal-mask .modal-container .modal-content form button.save {
  border: 3px solid #3498db;
  color: #3498db;
  margin-left: 1em;
}
.modal-mask .modal-container .modal-content form button.save:hover {
  background-color: #3498db;
}
.modal-mask .modal-container .modal-content form button.cancel {
  border: 3px solid #f39c12;
  color: #f39c12;
}
.modal-mask .modal-container .modal-content form button.cancel:hover {
  background-color: #f39c12;
}
.modal-mask .modal-container .modal-content form button:hover {
  color: white;
}

.modal-enter, .modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container, .modal-leave-active .modal-container {
  transform: scale(1.1);
}

.edit {
  color: orange;
  margin-left: auto;
  margin-right: 1em;
}
.edit:hover {
  text-decoration: underline;
}

</style>
