<%@include file="/WEB-INF/jspf/header.jspf" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Add Customer</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
                        <li class="breadcrumb-item active">Customer</li>
                        <li class="breadcrumb-item active">Add Customer</li>
                    </ol>
                </div>
            </div>

            <c:if test="${not empty msg}">
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
                    <h4><i class="icon fa fa-check"></i> ${msg}</h4>
                </div>
            </c:if>

            <c:if test="${not empty warnmsg}">
                <div class="alert alert-warning alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
                    <h4><i class="icon fa fa-check"></i> ${warnmsg}</h4>
                </div>
            </c:if>

            <c:if test="${not empty errmsg}">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
                    <h4><i class="icon fa fa-check"></i> ${errmsg}</h4>
                </div>
            </c:if>

            <span id="msg"></span>
        </div><!-- /.container-fluid -->
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card card-secondary">
                        <form id="form">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>Name:</label>

                                    <input type="text" class="form-control" id="name" name="name"
                                           placeholder="Name" autofocus>
                                </div>

                                <div class="form-group">
                                    <label>Email:</label>

                                    <input type="email" class="form-control" id="email" name="email"
                                           placeholder="Email">
                                </div>
                            </div>

                            <div class="card-footer">
                                <button type="submit" id="saveBtn" class="btn btn-primary">Save</button>
                                <button class="btn btn-default float-right" onclick="$('#form')[0].reset();">Cancel</button>
                            </div>
                        </form>
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
        $("#add_customer").addClass("active");

        $('#form').validate({
            rules: {
                name: {
                    required: true
                },
                email: {
                    required: true,
                    email: true
                }
            },
            submitHandler: function (form, event) {
                event.preventDefault();

                $("#saveBtn").prop("disabled",true);

                $.ajax({
                    type: "POST",
                    url: "/add_customer",
                    contentType: "application/json",
                    data: JSON.stringify($('#form').serializeJSON()),
                    success: function (result) {
                        if (result == "201") {
                            $("#form")[0].reset();
                            $('html,body').animate({scrollTop: 0}, 800);
                            $('#msg').append('<div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button><h4><i class="icon fa fa-check"></i>Customer added successfully</h4></div>');
                            $("#saveBtn").prop("disabled",false);
                        } else {
                            $('html,body').animate({scrollTop: 0}, 800);
                            $('#msg').append('<div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button><h4><i class="icon fa fa-check"></i>Customer added failed</h4></div>');
                            $("#saveBtn").prop("disabled",false);
                        }
                    },
                    error: function (err) {
                        $('html,body').animate({scrollTop: 0}, 800);
                        $('#msg').append('<div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button><h4><i class="icon fa fa-check"></i>Customer added failed</h4></div>');
                        $("#saveBtn").prop("disabled",false);
                    }
                });
            }
        });
    });
</script>
</body>
</html>
