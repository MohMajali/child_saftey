const User = require("../models/User");

exports.login = async (req, res, next) => {
  const { family_book_id, password } = req.body;

  try {
    const user = await User.findOne({
      where: { family_book_id, password },
    });

    if (user?.dataValues?.id) {
      return res.status(200).json({
        error: false,
        message: "Login success",
        id: user?.dataValues?.id,
      });
    }

    return res.status(404).json({
      error: true,
      message: "Email Or Password Incorrect",
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.signup = async (req, res, next) => {
  const { national_id, family_book_id, name, email, password, phone } =
    req.body;

  try {
    const newUser = await User.findOrCreate({
      where: { national_id },
      defaults: {
        type_id: 2,
        national_id,
        family_book_id,
        name,
        email : "test@yahoo.com",
        password,
        phone,
      },
    });

    if (!newUser[0]?._options?.isNewRecord) {
      return res.status(401).json({
        error: true,
        message: "Account Already Exist",
      });
    }

    return res.status(201).json({
      error: false,
      message: "Account Created Successfully",
      user: newUser[0],
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.updateAccount = async (req, res, next) => {
  const { name, email, password, phone } = req.body;
  const { id } = req.params;

  try {
    const updateUser = await User.update(
      {
        name,
        email,
        password,
        phone,
      },
      {
        where: { id },
      }
    );

    if (updateUser[0]) {
      return res.status(200).json({
        error: false,
        message: "Account Updated",
      });
    }

    return res.status(200).json({
      error: true,
      message: "Nothing Updated",
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.getUser = async (req, res, next) => {
  const { id } = req.params;
  try {
    const userData = await User.findOne({
      attributes: ["id", "name", "phone", "password", "email"],
      where: { id },
    });

    res.status(200).json({
      error: false,
      user_data: userData,
    });
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};
