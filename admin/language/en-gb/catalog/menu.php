<?php
    
    $languages = array(

        // Listing Page
        'heading_title' =>  'Menu',
        'text_list'     =>  'Menu List',
        
        'col_id'        =>  'ID',
        'col_title'     =>  'Title',
        'col_action'    =>  'Action',
        'col_status'  =>  'Status',

        'btn_new'       =>   'Add new menu',
        'btn_edit'      =>   'Edit menu',

        // Form page

        'text_form'    =>  'Update Menu',
        
        'field_title'   =>  'Menu Title',
        'field_status'  =>  'Status',
    );

    foreach($languages as $var => $language){
        $_[$var] = $language;
    }