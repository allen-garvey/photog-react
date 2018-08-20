import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './components/app.vue'
import ThumbnailList from './components/thumbnail-list.vue'


Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes: [
        { 
            path: '/', 
            name: 'home',
            component: ThumbnailList, 
            redirect: '/albums' 
        },
        { 
            path: '/albums',
            name: 'albumIndex', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'albumShow',
                thumbnailListKey: null,
            },
        },
        { 
            path: '/persons',
            name: 'personsIndex', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'personsShow',
                thumbnailListKey: null,
            },
        },
        { 
            path: '/albums/:id',
            name: 'albumShow', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'albumShow',
                thumbnailListKey: 'images',
            },
        },
        { 
            path: '/persons/:id',
            name: 'personsShow', 
            component: ThumbnailList,
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