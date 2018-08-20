<template>
    <header class="header container">
        <h1 class="brand"><router-link :to="{name: 'home'}">Photog</router-link></h1>
        <nav>
            <ul class="nav-list">
                <li><router-link :to="{name: 'albumIndex'}">Albums</router-link></li>
                <li><a href="/folders">Folders</a></li>
                <li><router-link :to="{name: 'personsIndex'}">Persons</router-link></li>
            </ul>
        </nav>
    </header>
</template>

<script>
export default {
    name: 'Photog-Header',
    props: {

    },
    components: {
    },
    data() {
        return {

        }
    },
    computed: {

    },
    created() {
    },
    methods: {

    }
}
</script>
