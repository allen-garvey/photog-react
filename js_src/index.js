import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './components/app.vue'
import ThumbnailList from './components/thumbnail-list.vue'
import TextList from './components/text-list.vue'
import ImageDetail from './components/image-detail.vue'


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
                itemShowRouteName: 'imagesShow',
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
        { 
            path: '/images/:id',
            name: 'imagesShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/images/${route.params.id}`
                }; 
            },
        },
        { 
            path: '/albums/:album_id/images/:image_id',
            name: 'albumImageShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/albums/${route.params.album_id}`,
                    parent: {
                        parentRouteName: 'albumsShow',
                        modelId: parseInt(route.params.image_id),
                        showRouteFor: (item)=>{
                            return {
                                name: 'albumImageShow',
                                params: {
                                    album_id: route.params.album_id,
                                    image_id: item.id,
                                },
                            };
                        },
                    },
                }; 
            },
        },
        { 
            path: '/persons/:person_id/images/:image_id',
            name: 'personImageShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/persons/${route.params.person_id}`,
                    parent: {
                        parentRouteName: 'personsShow',
                        modelId: parseInt(route.params.image_id),
                        showRouteFor: (item)=>{
                            return {
                                name: 'personImageShow',
                                params: {
                                    person_id: route.params.person_id,
                                    image_id: item.id,
                                },
                            };
                        },
                    },
                }; 
            },
        },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});