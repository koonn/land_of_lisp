; 周囲を見渡す ------
;; 基本の景色を描写する
(defparameter *nodes* '((living-room (you are in the living-room.
                                          a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                                     there is a well in front of you.))
                        (attic (you are in the attic.
                                    there is a giant welding torch in the corner.))))

;; 情景を描写する
(defun describe-location (location nodes)
  (cadr (assoc location nodes))) ; nodesの文字列はシンボルなので、cdrじゃなくてcadr




; 通り道を描写する
(defparameter *edges* '((living-room (garden west door)
                                     (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

; 必要なエッジの名前からテキストによる説明を得る
(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

  ; (describe-path '(garden west door))




; 複数の通り道を一度に描写する
(defun descrive-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr ( assoc location edges)))))




; 特定の場所にあるオブジェクトを描写する
;; ゲーム内に存在するオブジェクトのリスト
(defparameter *objects* '(whiskey bucket frog chain))

;; オブジェクトの場所を管理する変数
(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
                                   (chain garden)
                                   (frog garden)))

;; 与えられた場所から見えるオブジェクトのリストを返す関数
(defun objects-at (loc obj obj-locs)
  (labels ((at-loc-p (obj)
             (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

;; ある場所で見えるオブジェクトを描写する
(defun describe-objects (loc obj obj-locs)
  (labels ((describe-obj (obj) 
             `(you see a ,obj on the floor.)))
    (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))


