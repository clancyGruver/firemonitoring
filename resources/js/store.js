import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
  
  state: {
    divices: [],
    test:[{
  "text": "Dogs",
  "nodes": [{
    "text": "Germany",
    "nodes": [{
      "text": "American Eskimo Dog",
      "nodes": [{
        "text": "Fluffy",
        "link": {
          "type": "link", // Type `link` will create an `Anchor` tag
          "value": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/American_Eskimo_Dog_1.jpg/1920px-American_Eskimo_Dog_1.jpg" // URL of the link
        }
      }]
    }, {
      "text": "Bavarian Mountain Hound"
    }, {
      "text": "Boxer",
      "nodes": [{
        "text": "Rip (Router-link)",
        "link": {
          "type": "router-link", // Type `router-link` will create a router-link, duh.
          "key": "path", // key to use when giving it the value, router-link(:to="{ path: '/d-ger-boxer-rip' }")
          "value": "/d-ger-boxer-rip"
        }
      }, {
        "text": "Mackenzie (Router-link)",
        "link": {
          "type": "router-link",
          "key": "name",
          "value": "d-ger-boxer-machenzie"
        }
      }]
    }, {
      "text": "Bullenbeisser"
    }, {
      "text": "Dachshund"
    }, {
      "text": "Deutsche Bracke",
      "nodes": [{
        "text": "Mini",
        "link": {
          "type": "link",
          "value": "https://animalsbreeds.com/wp-content/uploads/2015/07/Deutsche-Bracke.jpg"
        }
      }]
    }]
  }, {
    "text": "France",
    "nodes": [{
      "text": "Ariegeois"
    }, {
      "text": "Artois Hound"
    }, {
      "text": "Barbet"
    }, {
      "text": "Beagle-Harrier"
    }, {
      "text": "Beauceron"
    }, {
      "text": "Berger Picard"
    }, {
      "text": "Bloodhound"
    }]
  }]
}, {
  "text": "Cats",
  "nodes": [{
    "text": "Russia",
    "nodes": [{
      "text": "Donskoy"
    }, {
      "text": "Kurilian Bobtail"
    }, {
      "text": "Mekong Bobtail"
    }, {
      "text": "Siberian"
    }]
  }, {
    "text": "Thailand",
    "nodes": [{
      "text": "Khao Manee"
    }, {
      "text": "Korat"
    }, {
      "text": "Korn Ja"
    }, {
      "text": "Suphalak",
      "nodes": [{
        "text": "Moon",
        "link": {
          "type": "link",
          "value": "https://www.pets4homes.co.uk/images/articles/4198/what-is-a-suphalak-cat-5947aefcd4845.jpg"
        }
      }]
    }]
  }]
}]

  },

  mutations: {
    SET_DEVICES: (state, payload) => {
      state.divices = payload;
    },
  },

  getters: {
	  DEVICES: state => {
	    return state.divices;
	  },
	}
});