.class final Landroid/telephony/GsmCellIdentity$1;
.super Ljava/lang/Object;
.source "GsmCellIdentity.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/telephony/GsmCellIdentity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Landroid/telephony/GsmCellIdentity;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Landroid/telephony/GsmCellIdentity;
    .locals 2
    .parameter "in"

    .prologue
    .line 140
    new-instance v0, Landroid/telephony/GsmCellIdentity;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Landroid/telephony/GsmCellIdentity;-><init>(Landroid/os/Parcel;Landroid/telephony/GsmCellIdentity$1;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1
    .parameter "x0"

    .prologue
    .line 137
    invoke-virtual {p0, p1}, Landroid/telephony/GsmCellIdentity$1;->createFromParcel(Landroid/os/Parcel;)Landroid/telephony/GsmCellIdentity;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Landroid/telephony/GsmCellIdentity;
    .locals 1
    .parameter "size"

    .prologue
    .line 145
    new-array v0, p1, [Landroid/telephony/GsmCellIdentity;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1
    .parameter "x0"

    .prologue
    .line 137
    invoke-virtual {p0, p1}, Landroid/telephony/GsmCellIdentity$1;->newArray(I)[Landroid/telephony/GsmCellIdentity;

    move-result-object v0

    return-object v0
.end method