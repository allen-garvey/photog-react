import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './components/app.vue'
import AlbumList from './components/album-list.vue'


Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes: [
        { 
            path: '/', 
            name: 'home',
            component: AlbumList, 
            redirect: '/albums' 
        },
        { 
            path: '/albums',
            name: 'albumIndex', 
            component: AlbumList 
        },
        { 
            path: '/albums/:id',
            name: 'albumShow', 
            component: AlbumList 
        },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});