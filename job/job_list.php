<?php
    require_once "$_SERVER[DOCUMENT_ROOT]/lib/job.php";
    require_once "$_SERVER[DOCUMENT_ROOT]/lib/common.php";
    require_once "$_SERVER[DOCUMENT_ROOT]/lib/MySmarty.php";

    $zipcode = $_REQUEST['zipcode'] ? $_REQUEST['zipcode'] : 200011;

    if($_REQUEST['search']) {
        try_get_job_list_div($zipcode);
    } else {
        try_get_job_list($zipcode);
    }

    function try_get_job_list($zipcode) {
        $res = get_job_list_by_zipcode_api($zipcode);
        if($res['errCode'] != 0) json_exit($res);

        show_page($res[result], "job/job_list.tpl");
    }

    function try_get_job_list_div($zipcode) {
        $res = get_job_list_by_zipcode_api($zipcode);
        if($res['errCode'] != 0) json_exit($res);

        show_page($res[result], "job/job_list_div.tpl");
    }

    function show_page($jobArray, $tpl){
        $smarty = new MySmarty();
        $smarty->assign('jobArray', $jobArray);
        @$smarty->display($tpl);
    }
?>