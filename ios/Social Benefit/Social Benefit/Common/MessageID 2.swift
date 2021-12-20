//
//  MessageID.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/12/2021.
//

import Foundation

struct MessageID {
    static let S00001_E = "S00001_E" // required
    static let S00011_E = "S00011_E" // image type must be (jpg,png,jpeg, gif)
    static let S00012_E = "S00012_E" // image size validation
    static let S00013_E = "S00013_E" // image isn't square
    static let S00004_I = "S00004_I" // no search data appropriate
    static let S00005_E = "S00005_E" // out of size
    static let S00007_E = "S00007_E" // wrong format email, date, etc.
    static let C00003_E = "C00003_E" // code exists
    static let C00024_I = "C00024_I" // code not exists
    static let A00042_E = "A00042_E" // save image failed
    static let A00006_E = "A00006_E" // invalid type
    static let C00043_E = "C00043_E" // Start day must be before end day
    static let C00046_E = "C00046_E"
    static let C00066_E = "C00066_E" // Cant delete
    static let C00666_E = "C00666_E" // Cant delete
    static let EXCEL_E = "EXCEL_E" // Excel Error
    static let C00054_E = "C00054_E" // Empty comment on reject
    static let A00080_E = "A00080_E" // not excel or csv
    static let A00081_E = "A00081_E" // parse excel/csv error
    static let A00015_E = "A00015_E" // Group required
    static let A00005_E = "A00005_E" // Max length
    static let A00057_E = "A00057_E" // Function permission
    static let A00059_I = "A00059_I" // Delete built-in group
    static let S00083_E = "S00083_E" // server error: file upload exceed max size
    static let A00089_E = "A00089_E" // input invalid information
    static let A00090_E = "A00090_E" // not valid data
    static let A00091_E = "A00091_E" // input 0 or 1
    static let C00092_E = "C00092_E" // post date must be before deadline date
    static let C00095_E = "C00095_E" // Luna date is not exists
    static let C00096_E = "C00096_E" // Email existed
    static let A00070_E = "A00070_E" // Login Failed
    static let A00072_E = "A00072_E" // User invalid
    static let A00107_E = "A00107_E" // Login Failed
    static let A00064_I = "A00064_I" // delete builtin data
    static let A00007_E = "A00007_E" // Invalid format
    static let A00067_E = "A00067_E" // Do not allows add user to group.
    static let A00068_E = "A00068_E" // Data existed in the system.
    static let C00104_E = "C00104_E" // Empty comment on reject (survey)
    static let M00087_E = "M00087_E" // validate start date > current date
    static let M00088_E = "M00088_E" // validate start date is before end date
    static let A00077_E = "A00077_E" // Email not valid.
    static let A00028_C = "A00028_C" // You do not have permission to perform this function.
    static let S00079_E = "S00079_E" // Invalid report date. Please check again.
    static let S00108_I = "S00108_I" // NotificationLog: Password has been reset
    static let S00109_I = "S00109_I" // NotificationLog: You just got reward !
    static let S00110_I = "S00110_I" // NotificationLog: Admin has rejected your benefit request.
    static let S00111_I = "S00111_I" // NotificationLog: Admin has accepted your benefit request.
    static let S00112_I = "S00112_I" // NotificationLog: Someone has comment related to you.
    static let M00069_E = "M00069_E" // more than one voucher code
    static let M00099_E = "M00099_E" // voucher price_minimum condition is not ok
    static let M00116_E = "M00116_E" // voucher has been used
    static let SERVER_E = "[server]" // server error
    static let S00117_E = "S00117_E" // not found company
    static let S00118_E = "S00118_E" // not found merchant
    static let S00119_E = "S00119_E" // not found user
    static let A00074_E = "A00074_E" // new password retype mismatch
    static let A00075_E = "A00075_E" // Invalid old password
    static let A00076_E = "A00076_E" // password must be 6~15 length
    static let S00120_E = "S00120_E"
    static let M00121_E = "M00121_E" // no voucher code found in system
    static let M00122_E = "M00122_E" // voucher code has no valid
    static let M00123_E = "M00123_E" // merchant can not use this voucher
    static let M00124_E = "M00124_E" // voucher can not used before start_time
    static let M00125_E = "M00125_E" // voucher can not used after end_time
    static let M00126_E = "M00126_E" // voucher not valid
    static let M00127_E = "M00127_E" // voucher has been used
    static let M00128_E = "M00128_E" // voucher has not been approved
    static let M00129_E = "M00129_E" // more than one voucher found
    static let M00093_E = "M00093_E" // The merchant contains a child/shop level merchant so it cannot be converted into a shop
    static let C00105_E = "C00105_E"
    static let C00106_E = "C00106_E"
    static let C00134_E = "C00134_E"
    static let C00138_E = "C00138_E"
    static let M00103_E = "M00103_E" // The expiration date of your contract with the system is {0}. The validity period of the voucher cannot exceed {0}!
    static let M00136_E = "M00136_E" // You have reached maximum of buying this voucher
    static let M00137_E = "M00137_E" // Remaining voucher quantity not enough
    static let C00142_E = "C00142_E" // Empty comment on reject
    static let C00143_E = "C00143_E" // benefit must have at least money, point or prize
    static let C00144_E = "C00144_E"
    static let C00145_E = "C00145_E"
    static let M00132_E = "M00132_E" // Date: {0} does not exist between {1} and {2}. Please check back.
    static let M00133_E = "M00133_E" // Th: {0} does not exist between {1} and {2}. Please check back.
    static let C00147_E = "C00147_E" // Comment parent not exists
    static let A00183_E = "A00183_E" // update built-in group
    static let A00184_E = "A00184_E" // update built-in user
    static let C00150_I = "C00150_I" // Comment parent not exists
    static let S00155_I = "S00155_I" // You have received benefit (for mobile notification_log)
    static let C00148_E = "C00148_E" // join and leave company of employee is out of applied benefit date
    static let C00156_E = "C00156_E" // join company of employee is out of applied benefit date
    static let C00157_E = "C00157_E" // // The parent merchant have already deleted
    static let C00186_E = "C00186_E " // End year must be greater than or equal apply year
    static let C00158_E = "C00158_E" // benefit birthday can not have loop by month
    //Tuan Anh fix bug 1910
    static let S00111_E = "S00111_E" // Notification sent
    //Tuan Anh fix bug 2008
    static let S00112_E = "S00112_E" // benefit happening can't update
    static let C00153_E = "C00153_E" // department point qty < 0
    static let C00159_I = "C00159_I" // format notification for mobile
    static let C00164_I = "C00164_I" // format notification for mobile
    static let C00162_E = "C00162_E" // budget benefit limit.
    static let C00167_E = "C00167_E" // registration deadline <= apply date - 3.
    static let C00168_E = "C00168_E" // not enough personal point
    static let C00169_E = "C00169_E" // not enough department point
    static let C00174_E = "C00174_E" // can not send to self
    static let C00175_E = "C00175_E" // at least one employee is not active
    static let C00176_E = "C00176_E" // transaction fail due to check after transaction wallet point
    static let C00177_E = "C00177_E" // no point has been transferred
    static let C00179_E = "C00179_E" // The registration deadline must be greater than the current date.
    static let C00181_E = "C00181_E" // Can not reject benefit is going on.
    static let C00182_E = "C00182_E" // Can't create benefit. The benefit apply date ({0}) cannot be after the expiration date of the company's contract in the platform ({1}).
    static let C00161_I = "C00161_I" // Can't change status
    static let S00166_E = "S00166_E" // Can't update budget point
    static let C00187_E = "C00187_E" // benefit register error: not enough point
    static let C00188_E = "C00188_E" // benefit register error: not enough slot (full applied)
    static let C00189_E = "C00189_E" // benefit register error: not enough slot (but still has chance)
    static let C00190_E = "C00190_E" // benefit register error: over deadline
}
