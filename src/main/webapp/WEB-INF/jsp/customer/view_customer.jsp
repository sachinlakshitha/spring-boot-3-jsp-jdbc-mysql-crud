<%@include file="/WEB-INF/jspf/header.jspf" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>View Customer</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item active">Customer</li>
                        <li class="breadcrumb-item active">View Customer</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card card-secondary">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="table" class="table table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Created Time</th>
                                            <th style="width: 55px;"></th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                    </tbody>

                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@include file="/WEB-INF/jspf/footer.jspf" %>

<script>
    $(function () {
        $(".customer").removeClass("treeview").addClass("treeview menu-open");
        $("#customer-menu").css('display', 'block');
        $("#view_customer").addClass("active");

        loadCustomerTable();
    });

    function loadCustomerTable() {
        $('#table').DataTable({
            "pageLength": 10,
            "ajax": "/view_customer_dt",
            "destroy": true
        });
    }

    function deleteCustomer(id) {
        Swal.fire({
            title: 'Are you sure?',
            text: "",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Delete'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "DELETE",
                    url: "/delete_customer/"+id,
                    success: function (res) {
                        if(res == 200){
                            loadCustomerTable();
                        }else{
                            Swal.fire({
                                position: 'top-end',
                                icon: 'error',
                                title: 'Customer delete failed',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    },
                    error: function (err) {
                        Swal.fire({
                            position: 'top-end',
                            icon: 'error',
                            title: 'Customer delete failed',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                });
            }
        });
    }
</script>
</body>
</html>
