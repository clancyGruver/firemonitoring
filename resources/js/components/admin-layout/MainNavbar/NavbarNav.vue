<template>
  <d-navbar-nav class="border-left flex-row">
    <li class="nav-item">
      <a class="nav-link text-nowrap px-3" v-d-toggle.user-actions>        
        <span class="d-none d-md-inline-block"><i class="material-icons text-danger">&#xE879;</i> Logout</span>
      </a>
    </li>
  </d-navbar-nav>
</template>

<style>
  .nav-link:hover {
    cursor: pointer;
  }
</style>
