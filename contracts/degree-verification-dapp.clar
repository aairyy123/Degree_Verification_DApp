;; Degree Verification Contract
;; A tool to verify academic degrees on the blockchain

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-degree-not-found (err u101))
(define-constant err-invalid-status (err u102))

;; Degree information storage
(define-map degrees uint { 
    student-id: uint,
    institution: (string-utf8 256),
    degree-name: (string-utf8 256),
    year: uint,
    status: (string-ascii 20), ;; "added", "pending", "in-process", "completed"
    verified: bool,
    ai-verified: bool,
    verification-hash: (buff 32)
})

;; Function 1: Add/Update Degree with Manual Verification
(define-public (add-degree 
    (degree-id uint) 
    (student-id uint)
    (institution (string-utf8 256))
    (degree-name (string-utf8 256))
    (year uint)
    (status (string-ascii 20))
    (verification-hash (buff 32)))
    (begin
        (asserts! (or (is-eq tx-sender contract-owner) 
                     (is-eq status "added")) err-owner-only)
        (asserts! (or (is-eq status "added") 
                     (is-eq status "pending") 
                     (is-eq status "in-process") 
                     (is-eq status "completed")) err-invalid-status)
        
        (map-set degrees degree-id {
            student-id: student-id,
            institution: institution,
            degree-name: degree-name,
            year: year,
            status: status,
            verified: false,
            ai-verified: false,
            verification-hash: verification-hash
        })
        (ok true)
    )
)

;; Function 2: Verify Degree (with AI option)
(define-public (verify-degree 
    (degree-id uint) 
    (verification-hash (buff 32))
    (ai-verification bool))
    (begin
        (let ((degree (unwrap! (map-get? degrees degree-id) err-degree-not-found)))
        (asserts! (is-eq (get verification-hash degree) verification-hash) err-degree-not-found)
        
        (map-set degrees degree-id (merge degree {
            verified: true,
            ai-verified: ai-verification,
            status: "completed"
        }))
        (ok true)
    )
)

)
