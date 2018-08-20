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
            component: AlbumList,
            props: {
                itemShowRouteName: 'albumShow',
                thumbnailListKey: null,
            },
        },
        { 
            path: '/persons',
            name: 'personsIndex', 
            component: AlbumList,
            props: {
                itemShowRouteName: 'personsShow',
                thumbnailListKey: null,
            },
        },
        { 
            path: '/albums/:id',
            name: 'albumShow', 
            component: AlbumList,
            props: {
                itemShowRouteName: 'albumShow',
                thumbnailListKey: 'images',
            },
        },
        { 
            path: '/persons/:id',
            name: 'personsShow', 
            component: AlbumList,
            props: {
                itemShowRouteName: 'personsShow',
                thumbnailListKey: 'images',
            },
        },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});