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
                itemsListKey: null,
            },
        },
        { 
            path: '/albums',
            name: 'albumsIndex', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'albumsShow',
                itemsListKey: null,
            },
        },
        { 
            path: '/persons',
            name: 'personsIndex', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'personsShow',
                itemsListKey: null,
            },
        },
        { 
            path: '/albums/:id',
            name: 'albumsShow', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'imagesShow',
                itemsListKey: 'images',
            },
        },
        { 
            path: '/persons/:id',
            name: 'personsShow', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'personsShow',
                itemsListKey: 'images',
            },
        },
        { 
            path: '/folders/:id',
            name: 'foldersShow', 
            component: ThumbnailList,
            props: {
                itemShowRouteName: 'albumsShow',
                itemsListKey: 'albums',
            },
        },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});