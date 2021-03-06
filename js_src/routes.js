import ThumbnailList from './components/thumbnail-list.vue'
import TextList from './components/text-list.vue'
import ImageDetail from './components/image-detail.vue'

export default {
    mode: 'history',
    routes: [
        { 
            path: '/', 
            name: 'home',
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
            props: (route) => {
                return {
                    apiPath: route.path,
                    showRouteFor: (item)=>{
                        return {
                            name: 'albumsShow',
                            params: {
                                id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/persons',
            name: 'personsIndex', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: route.path,
                    showRouteFor: (item)=>{
                        return {
                            name: 'personsShow',
                            params: {
                                id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/images',
            name: 'imagesIndex', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: route.path,
                    showRouteFor: (item)=>{
                        return {
                            name: 'imagesShow',
                            params: {
                                id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/images/favorites',
            name: 'imageFavoritesIndex', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: '/images/?favorites=true',
                    showRouteFor: (item)=>{
                        return {
                            name: 'imagesShow',
                            params: {
                                id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/albums/:id',
            name: 'albumsShow', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: route.path,
                    itemsListKey: 'images',
                    showRouteFor: (item)=>{
                        return {
                            name: 'albumImagesShow',
                            params: {
                                album_id: route.params.id,
                                image_id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/persons/:id',
            name: 'personsShow', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: route.path,
                    itemsListKey: 'images',
                    showRouteFor: (item)=>{
                        return {
                            name: 'personImagesShow',
                            params: {
                                person_id: route.params.id,
                                image_id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/folders/:id',
            name: 'foldersShow', 
            component: ThumbnailList,
            props: (route) => {
                return {
                    apiPath: route.path,
                    itemsListKey: 'albums',
                    showRouteFor: (item)=>{
                        return {
                            name: 'albumsShow',
                            params: {
                                id: item.id,
                            },
                        };
                    },
                }; 
            },
        },
        { 
            path: '/images/:id',
            name: 'imagesShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/images/${route.params.id}`,
                    imageId: parseInt(route.params.image_id),
                }; 
            },
        },
        { 
            path: '/albums/:album_id/images/:image_id',
            name: 'albumImagesShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/albums/${route.params.album_id}`,
                    imageId: parseInt(route.params.image_id),
                    parent: {
                        parentRouteName: 'albumsShow',
                        showRouteFor: (item)=>{
                            return {
                                name: 'albumImagesShow',
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
            name: 'personImagesShow', 
            component: ImageDetail,
            props: (route) => {
                return {
                    modelApiPath: `/persons/${route.params.person_id}`,
                    imageId: parseInt(route.params.image_id),
                    parent: {
                        parentRouteName: 'personsShow',
                        showRouteFor: (item)=>{
                            return {
                                name: 'personImagesShow',
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
};