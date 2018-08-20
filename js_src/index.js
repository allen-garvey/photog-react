import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './components/app.vue'
import ThumbnailList from './components/thumbnail-list.vue'
import TextList from './components/text-list.vue'


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
            path: '/folders',
            name: 'foldersIndex', 
            component: TextList,
            props: {
                itemShowRouteName: 'foldersShow',
                thumbnailListKey: null,
            },
        },
        { 
            path: '/albums',
            name: 'albumsIndex', 
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
        { 
            path: '/folders/:id',
            name: 'foldersShow', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'albumShow',
                thumbnailListKey: 'albums',
            },
        },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});